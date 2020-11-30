RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    it '引数が与えられていない場合ベースタイトルを返すこと' do
      expect(full_title("")).to eq('MATCHING-AC')
    end

    it '引数が与えられている場合ベース,ページタイトルを返すこと' do
      expect(full_title('Home')).to eq('Home | MATCHING-AC')
    end

    it '引数がnilの場合ベースタイトルを返すこと' do
      expect(full_title(nil)).to eq('MATCHING-AC')
    end
  end
end
