require 'net/http'
require 'json'
require 'ox'
require 'active_support/core_ext/hash'
require 'nokogiri'

require 'equifax/client'
# Base
require 'equifax/worknumber/base'
# VOE
require 'equifax/worknumber/voe/instant'
require 'equifax/worknumber/voe/researched/retrieve'
require 'equifax/worknumber/voe/researched/status'
require 'equifax/worknumber/voe/researched/submit'
# VOI
require 'equifax/worknumber/voi/instant'
require 'equifax/worknumber/voi/researched/retrieve'
require 'equifax/worknumber/voi/researched/status'
require 'equifax/worknumber/voi/researched/submit'
#4506T
require 'equifax/worknumber/vo4506t/base'
require 'equifax/worknumber/vo4506t/submit'
require 'equifax/worknumber/vo4506t/status'
require 'equifax/worknumber/vo4506t/retrieve'

require 'equifax/version'

module Equifax
end
