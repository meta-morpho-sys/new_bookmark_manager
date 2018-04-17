# frozen_string_literal: true

class Route
  ROOT = '/'
  USER_NEW = '/users/new'
  USERS = '/users'
  BOOKMARKS = '/bookmarks'
  BOOKMARK_NEW = '/bookmarks/new'
  BOOKMARK_DELETE = '/bookmarks/:id/delete'
  # '/bookmarks/:id/edit'
  # '/bookmarks/:id/update'
  # '/bookmarks/:id/commen
  # '/bookmarks/comments/n
  # '/bookmark/:id/comments/view'
  # '/bookmarks/:id/tags'
  # '/bookmarks/tags/new'
  # '/tags/:id/bookmarks'
  #

  def self.bookmark_delete(bookmark)
    BOOKMARK_DELETE % { id: bookmark.id }
  end

end
