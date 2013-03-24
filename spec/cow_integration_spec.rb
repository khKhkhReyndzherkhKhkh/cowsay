require 'rack/test'
require 'cow'

set :environment, :test

describe "The cow app" do
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  it "generates a cow" do
    expected = (<<'END').strip
 _______ 
< Hello >
 ------- 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
END
  
      get '/'
      result = last_response.body.strip
      result.should eq(expected)
  end
  
  it 'uses a message parameter if supplied' do
    expected = (<<'END').strip
 __________ 
< Good Bye >
 ---------- 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
END

    get '/', 'message' => "Good Bye"
    result = last_response.body.strip
    result.should eq(expected)    
  end
  
  it 'accepts a cowfile parameter' do
      expected = (<<'END').strip
 _______ 
< Hello >
 ------- 
\                             .       .
 \                           / `.   .' " 
  \                  .---.  <    > <    >  .---.
   \                 |    \  \ - ~ ~ - /  /    |
         _____          ..-~             ~-..-~
        |     |   \~~~\.'                    `./~~~/
       ---------   \__/                        \__/
      .'  O    \     /               /       \  " 
     (_____,    `._.'               |         }  \/~~~/
      `----.          /       }     |        /    \__/
            `-.      |       /      |       /      `. ,~~|
                ~-.__|      /_ - ~ ^|      /- _      `..-'   
                     |     /        |     /     ~-.     `-. _  _  _
                     |_____|        |_____|         ~ - . _ _ _ _ _>
END

      get '/', 'cowfile' => "stegosaurus"
      result = last_response.body.strip
      result.should eq(expected)    
    end  
    
    describe '/cowfiles' do
      def do_request
        get '/cowfiles'
      end
      
      it 'returns cowfiles with a JSON content type' do
        do_request
        last_response.content_type.should match(/application\/json/)
      end
      
      it 'returns a list of available cowfiles in JSON' do
        do_request
        result = JSON.parse(last_response.body.strip)
        result.should eq(%w[
          beavis.zen bong bud-frogs bunny cheese cower daemon default dragon
          dragon-and-cow elephant elephant-in-snake eyes flaming-sheep ghostbusters
          head-in hellokitty kiss kitty koala kosh luke-koala meow milk moofasa moose
          mutilated ren satanic sheep skeleton small sodomized stegosaurus stimpy
          supermilker surgery telebears three-eyes turkey turtle tux udder vader
          vader-koala www          
        ])
      end
        
    end    
end