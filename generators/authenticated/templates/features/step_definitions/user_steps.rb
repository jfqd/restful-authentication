Given /^I am not logged in$/ do
  visit '/logout'
end

Then /^I should not be logged in$/ do
  controller.current_<%= file_name %>.should be_nil
end

Then /^I should be logged in$/ do
  controller.current_<%= file_name %>.should_not be_nil
end

Given /^someone with login "([^\"]*)" already exists$/ do |login|
  <%= class_name %>.make(:login => login)
end