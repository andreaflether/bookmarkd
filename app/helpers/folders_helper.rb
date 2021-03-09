# frozen_string_literal: true

module FoldersHelper
  def truncated_description(description)
    description.truncate(70) if description.present?
  end

  def datetime_formatted(datetime)
    datetime.strftime('%B %d, %Y %H:%M')
  end

  def pluralize_bookmarks_count(folder)
    pluralize(folder.bookmarks_count, 'bookmark')
  end

  def state_name(folder)
    folder.pinned? ? 'Unpin' : 'Pin'
  end

  def privacy_options
    [
      %w[open Public],
      %w[secret Private]
    ]
  end

  def keyword_confirmation(resource)
    username = current_user.username
    created_at = resource.created_at.strftime('%m%d%y')
    "#{username}/#{created_at}"
  end
end
