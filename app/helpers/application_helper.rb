module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { sort: column, direction: direction }, { class: css_class }
  end

  # Defines the method for showing markdown formatting on the #show page.
  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                          autolink: true,
                                          space_after_headers: true,
                                          fenced_code_blocks: true )
    @markdown.render(content)
  end
end
