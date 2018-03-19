feature 'Viewing links' do
  scenario 'A user can see links' do
    visit '/'
    expect(page).to have_content 'https://online.lloydsbank.co.uk/personal/logon/login.jsp?messageKey=IB:9210358&mobile=false'
    expect(page).to have_content 'https://www.borrowmydoggy.com/search/dogs'
    expect(page).to have_content 'http://vogliadicucina.blogspot.co.uk/2015/11/biscotti-con-avena-e-albicocche.html'
  end
end
