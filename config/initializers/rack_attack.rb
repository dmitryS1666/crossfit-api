# Rack::Attack.safelist_ip("178.159.47.83, 199.195.151.164")
Rack::Attack.safelist_ip('178.159.47.83')
Rack::Attack.safelist_ip('178.168.224.90')
# Provided that trusted users use an HTTP request header named APIKey
Rack::Attack.safelist('mark any authenticated access safe') do |request|
  # Requests are allowed if the return value is truthy
  request.env[
    'APIKey'
  ] ==
    'RYGl!sTSxCuu'
end

# Always allow requests from localhost
# (blocklist & throttles are skipped)
Rack::Attack.safelist('allow from localhost') do |req|
  # Requests are allowed if the return value is truthy
  '127.0.0.1' ==
    req.ip ||
    '::1' == req.ip
end

Rack::Attack.blocklist('block all access to admin') do |request|
end

# Block suspicious requests for '/etc/password' or wordpress specific paths.
# After 3 blocked requests in 10 minutes, block all requests from that IP for 5 minutes.
Rack::Attack.blocklist('fail2ban pentesters') do |req|
  # `filter` returns truthy value if request fails, or if it's from a previously banned IP
  # so the request is blocked
  Rack::Attack::Fail2Ban
    .filter(
    "pentesters-#{req.ip}",
    maxretry: 3, findtime: 10.minutes, bantime: 5.minutes
  ) do
    # The count for the IP is incremented if the return value is truthy
    CGI.unescape(req.query_string) =~ %r{/etc/passwd} ||
      req.path.include?('/etc/passwd') ||
      req.path.include?('wp-admin') ||
      req.path.include?('wp-login')
  end
end
