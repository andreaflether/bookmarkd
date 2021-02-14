# frozen_string_literal: true

module FoldersHelper
  def is_pinned(folder)
    folder.pinned?
  end

  def folder_description(description)
    description.truncate(70) unless description_blank?(description)
  end

  def description_blank?(description)
    description.blank?
  end

  def datetime_formatted(datetime)
    datetime.strftime('%B %d, %Y %H:%M')
  end

  def pluralize_bookmarks_count(folder)
    pluralize(folder.bookmarks_count, 'bookmark')
  end

  def state_name(folder)
    is_pinned(folder) ? 'Unpin' : 'Pin'
  end
end
