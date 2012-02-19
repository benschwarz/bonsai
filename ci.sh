source $HOME/.rvm/scripts/rvm

ruby_vms=( 1.8.7 1.9.2 1.9.3 jruby-18mode jruby-19mode rbx-18mode rbx-19mode ruby-head )

for vm in "${ruby_vms[@]}"
do
  echo "Running build with ${vm}"
	rvm use ${vm} && bundle install && bundle exec rake
done
