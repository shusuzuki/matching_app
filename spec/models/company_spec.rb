RSpec.describe Company, type: :model do
  let(:company) { FactoryBot.create(:company) }

  it "FactoryBotが有効である" do
    expect(company).to be_valid
  end

  it "企業名がなければ登録できない" do
    expect(FactoryBot.build(:company, company_name: "")).not_to be_valid
  end

  it "文字数が制限内である" do
    expect(FactoryBot.build(:company, company_name: "a" * 31)).not_to be_valid
    expect(FactoryBot.build(:company, email: "a" * 31)).not_to be_valid
    expect(FactoryBot.build(:company, password: "a" * 5)).not_to be_valid
  end

  it "メールアドレスがなければ登録できない" do
    expect(FactoryBot.build(:company, email: "")).not_to be_valid
  end

  it "メールアドレスが重複していたら登録できない" do
    company1 = FactoryBot.create(:company, company_name: "taro", email: "taro@example.com")
    expect(FactoryBot.build(:company, company_name: "ziro", email: company1.email)).not_to be_valid
  end

  describe "メールアドレスの有効性" do
    it "無効なメールアドレス" do
      invalid_addresses = ["user.name@example.foo@bar_baz.com", "foo@bar+baz.com"]
      invalid_addresses.each do |invalid_address|
        company.email = invalid_address
        expect(company).not_to be_valid
      end
    end

    it "有効なメールアドレス" do
      valid_addresses = ["user@foo.COM", "A_US-ER@f.b.org", "frst.lst@foo.jp", "a+b@baz.cn"]
      valid_addresses.each do |valid_address|
        company.email = valid_address
        expect(company).to be_valid
      end
    end
  end

  it "パスワードがなければ登録できない" do
    expect(FactoryBot.build(:company, password: "")).not_to be_valid
  end
end
