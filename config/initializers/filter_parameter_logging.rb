# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
# :passwordというパラメーターはログに記録しない
Rails.application.config.filter_parameters += [:password]
