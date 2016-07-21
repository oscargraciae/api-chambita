"""environment ENV['RACK_ENV']
threads 0,5

workers 3
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end"""


#workers Integer(ENV['WEB_CONCURRENCY'] || 2)
#threads_count = Integer(ENV['MAX_THREADS'] || 5)
#threads threads_count, threads_count
#rackup      DefaultRackup
#port        ENV['PORT']     || 3000
#environment ENV['RACK_ENV'] || 'development'

# pidfile 'tmp/pids/puma.pid'
# state_path 'tmp/pids/puma.state'
# bind 'unix:///var/run/my_app.sock'

environment ENV['RACK_ENV']
threads 0,5

workers 3
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.establish_connection
  end

end


#RUN chown -R www-data:www-data /var/lib/nginx
