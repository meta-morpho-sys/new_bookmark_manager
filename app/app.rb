require 'sinatra/base'
# Controller
class BookmarkManager < Sinatra::Base

  get '/' do
    links = [
      'https://online.lloydsbank.co.uk/personal/logon/login.jsp?messageKey=IB:9210358&mobile=false',
      'https://www.borrowmydoggy.com/search/dogs',
      'http://vogliadicucina.blogspot.co.uk/2015/11/biscotti-con-avena-e-albicocche.html'
    ]
    links.join
  end


  run! if app_file == $PROGRAM_NAME
end
