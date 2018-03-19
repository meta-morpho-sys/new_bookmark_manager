require_relative '../models/link'

describe Link do
  describe '.all' do
    it 'has all links' do
      links = Link.all

      expect(links).to include 'https://online.lloydsbank.co.uk/personal/logon/login.jsp?messageKey=IB:9210358&mobile=false'
      expect(links).to include 'https://www.borrowmydoggy.com/search/dogs'
      expect(links).to include 'http://vogliadicucina.blogspot.co.uk/2015/11/biscotti-con-avena-e-albicocche.html'
    end
  end
end
