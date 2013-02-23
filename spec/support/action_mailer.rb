def mail_delivery(options={})
  
  ActionMailer::Base.deliveries = []

  yield 
  
  !ActionMailer::Base.deliveries.empty?
 
end
