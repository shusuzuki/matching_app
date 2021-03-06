RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "FactoryBotが有効である" do
    expect(user).to be_valid
  end

  it "名前がなければ登録できない" do
    expect(build(:user, name: "")).not_to be_valid
  end

  it "文字数が制限内である" do
    expect(build(:user, name: "a" * 31)).not_to be_valid
    expect(build(:user, email: "a" * 31)).not_to be_valid
    expect(build(:user, password: "a" * 5)).not_to be_valid
    expect(build(:user, profile: "a" * 51)).not_to be_valid
  end

  it "メールアドレスがなければ登録できない" do
    expect(build(:user, email: "")).not_to be_valid
  end

  it "メールアドレスが重複していたら登録できない" do
    user1 = create(:user, name: "taro", email: "taro@example.com")
    expect(build(:user, name: "ziro", email: user1.email)).not_to be_valid
  end

  describe "メールアドレスの有効性" do
    it "無効なメールアドレス" do
      invalid_addresses = ["user.name@example.foo@bar_baz.com", "foo@bar+baz.com"]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end
    it "有効なメールアドレス" do
      valid_addresses = ["user@foo.COM", "A_US-ER@f.b.org", "frst.lst@foo.jp", "a+b@baz.cn"]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  it "パスワードがなければ登録できない" do
    expect(build(:user, password: "")).not_to be_valid
  end

  it 'パスワードが確認用と一致していない場合、無効である' do
    user = build(:user, password_confirmation: 'aaaaaa')
    user.valid?
    expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
  end
end
