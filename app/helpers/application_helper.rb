module ApplicationHelper
  def markdown_to_html(markdown)
    # takes the markdown and changes to html
    renderer = Redcarpet::Render::HTML.new
    # ```
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    # you have to pass html safe so it gets rid of quotes
    (redcarpet.render markdown).html_safe
  end
end
