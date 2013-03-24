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
end