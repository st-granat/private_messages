# coding: utf-8
class String
  def make_re
    self.include?("RE:") ? self : "RE: #{self}"
  end
end
