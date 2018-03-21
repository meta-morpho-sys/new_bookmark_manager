feature 'Viewing links' do
  scenario 'A user can see links' do
    visit '/'
    expect(page).to have_content 'https://online.lloydsbank.co.uk'
    expect(page).to have_content 'https://www.borrowmydoggy.com/search/dogs'
    expect(page).to have_content 'http://vogliadicucina.blogspot.co.uk'
  end
end
