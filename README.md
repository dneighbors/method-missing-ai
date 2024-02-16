# Overview
Less a project and more a funny hack.  @refriedchicken the other day mentioned that it would be great to make it so method missing would just use AI to implement the method rather than throw an error.  So at a hacknight later that day a few of us threw together a quick implementation to show the stupid silly power of AI and Ruby.  Think something like "[thefuck](https://github.com/nvbn/thefuck)"  only in your ruby app calling methods...

## Setup
1. Install [ruby-openai](https://github.com/alexrudall/ruby-openai)
`gem install ruby-openai`
2. Install dotenv
`gem install dotenv`
3. Copy .env file for access token
`cp .env.sample .env`
4. Add your open AI access token to .env that was copied
5. Fire up IRB in console in same directory as this project
6. Type `load 'aimissing.rb'`
7. Type `someobject = MyDynamicClass.new`
8. Type `someobject.anymethod(anyparams)` ie: any method and params you want
You will get an AI generated response for that method and parameter set.
ex: someobject.add(2, 5) will return 7

## Quick Tutorial
[![Tutorial](https://cdn.loom.com/sessions/thumbnails/fff86fdf1c654299b594e9cff3e227f2-1708122392387-with-play.gif)](https://www.loom.com/share/fff86fdf1c654299b594e9cff3e227f2)

## Thank You's
* [Ruby AI Builders Community](https://discord.gg/29nHa6fT)
* [Alex Rudall](https://twitter.com/alexrudall)
* [ruby-openai](https://github.com/alexrudall/ruby-openai)
