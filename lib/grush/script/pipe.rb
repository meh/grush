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

module Grush; class Script

module Pipeable
  def | (value)
    return unless @script

    from, into = @script.to_a.pop(2)

    @script.to_a << Pipe.new(from, into, @script)
  end
end

class Pipe
  include Pipeable

  attr_reader :from, :into

  def initialize (from, into, script=nil)
    @from = from
    @into = into

    @script = script
  end

  def to_s
    "(#{from.to_s} | #{into.to_s})"
  end
end

end; end
