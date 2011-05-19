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

module Redirectable
  def > (value)
    return unless @script

    from = @script.to_a.pop

    @script.to_a << Redirect.new(from, value, @script)
  end

  def < (value)
    to = @script.to_a.pop

    @script.to_a << Redirect.new(value, to, @script)
  end
end

class Redirect
  attr_reader :from, :to

  def initialize (from, to, script=nil)
    @from = from
    @to   = to

    @script = script
  end

  def to_s
    if @from.is_a?(String)
      "(#{@to.to_s} < #{@from})"
    else
      "(#{@from.to_s} > #{@to})"
    end
  end
end

end; end
