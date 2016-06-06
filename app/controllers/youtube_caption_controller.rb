class GameController < ApplicationController

  skip_before_filter :verify_authenticity_token


  allow_headers = 'Origin, Authorization, Accept, Content-Type, X-HTTP-Method-Override'


  def youtube_id(url)
    url.match(/^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/)[-1]
  end

end
