# frozen_string_literal: true

class MsgStrings

  BACK_LINK = 'Back to Bookmarks'
  BACK_SIGN_UP = 'Back to Sign up'
  BKMARK_DELETED = ->(bm_id) { "Bookmark #{bm_id} was successfully deleted." }
  DUPLICATE_ADDRESS = 'This address is already used, choose another.'
  DUPLICATE_TITLE = 'That title is already taken, choose another.'
  GENERIC_DB_ERROR = 'Something went wrong with the database. \
                        This sometimes happens, please try again.'
  SIGN_OUT = 'You successfully signed out'
  TAG_ASSIGNED = ->(tag_content) { "'#{tag_content}' tag successfully assigned" }
  TAG_CREATED = ->(tag_content) { "'#{tag_content}' tag successfully created" }

  VALID_URL = 'You must submit a valid URL'
end

