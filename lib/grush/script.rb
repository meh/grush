#--
# Copyleft meh. [http://meh.paranoid.pk | meh@paranoici.org]
#
# This file is part of grush.
#
# packo is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# packo is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with packo. If not, see <http://www.gnu.org/licenses/>.
#++

require 'grush/script/command'
require 'grush/script/pipe'
require 'grush/script/redirect'

module Grush

class Script
  def initialize (&block)
    reset!

    if block
      if block.arity != 0
        yield self if block_given?
      else
        instance_eval &block
      end
    end
  end

  def reset!
    @commands = []
  end

  def empty?
    @commands.empty?
  end

  def << (string)
    @commands << Command.parse(string, self)

    @commands.last
  end

  def method_missing (id, *args, &block)
    self[id, *args]
  end

  def [] (name, *args)
    cmd = name.to_s.shellsplit + args

    @commands << Command.new(cmd.shift, cmd, self)

    @commands.last
  end

  def to_s
    result = "#! /bin/sh\n"

    @commands.each {|cmd|
      result << "#{cmd.to_s}\n"
    }

    result
  end

  def to_a
    @commands
  end
end

end
