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

require 'grush/script/pipe'
require 'grush/script/redirect'

module Grush; class Script

class Command
  include Pipeable
  include Redirectable

  def self.parse (text, script=nil)
    cmd = text.to_s.shellsplit

    Command.new(cmd.shift, cmd, script)
  end

  attr_reader :name, :arguments

  def initialize (name, *args)
    @name = name

    if args.last.is_a?(Script)
      @script = args.pop
    end

    @arguments = args.flatten.compact
  end

  def to_s
    "(#{([@name] + @arguments).shelljoin})"
  end
end

end; end
