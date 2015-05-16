# Perform the check as specified, except substitute the sorting code with
# 090126, for check purposes only
class Exception8 < BaseException
  def apply_sort_code_substitutions
    return '090126'
  end
end
