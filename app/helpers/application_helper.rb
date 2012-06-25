module ApplicationHelper

  def days_since(old_date)
    (Date.today - old_date).to_i + 2
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
