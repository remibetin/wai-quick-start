###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
 activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
  def x_link_to(link_text, url, options = {})
    options[:class] ||= ""
    if url == '/' + current_page.path
      options[:class] << " current"
      '<span class="current-a">' + link_text + '</span>'
    else
      link_to(link_text, url, options)
    end
  end

  def is_current(url)
    url == current_page.path
  end
  
  def nav_link(link_text, url, options = {})
    options[:class] ||= ""
    
    if is_current(url)
      '<span class="label"><span id="current-icon">»</span>' + link_text + '</span>'
    else
      link_to(link_text, url, options)
    end
  end
  
  def list_nav_link(link_text, url, options = {})
    if is_current(url)
      '<li id="current-node" class="current-nav"><span class="label"><span id="current-icon">»</span>' + link_text + '</span></li>'
    else
      '<li>' + link_to(link_text, url, options) + '</li>'
    end
  end

  def tip_start
    '<article class="tip">'
  end

  def tip_end
    '</article>'
  end

  def learn_more_start
    '<aside class="learn_more"><h3>Learn more</h3>'
  end
  
  def learn_more_end
    '</aside>'
  end

  def example_start(plural = nil)
    if plural
      '<aside class="learn_more"><h3>Examples</h3>'
    else
      '<aside class="learn_more"><h3>Example</h3>'
    end
  end
  
  def example_end
    '</aside>'
  end
end

set :markdown_engine, :kramdown
activate :autoprefixer, browsers: ['last 2 versions', 'ie 8', 'ie 9']

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'img'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  set :relative_links, true
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :git
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch   = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end
