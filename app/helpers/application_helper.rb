module ApplicationHelper

  def months_since(old_date)
    (Date.today.month + (12 * Date.today.year)) - (old_date.month + (12 * old_date.year)) + 1
  end

  def standardize_provider(provider)
    if ["Living Social", "Livingsocial", "livingsocial", "Living Social Advntures"].include?(provider)
      "livingsocial"
    else
      provider
    end
  end

  def revenue_or_zero(revenue)
    revenue.class == Integer ? revenue : 0
  end
end
