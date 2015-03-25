package 'php-mysql' do
  package_name value_for_platform_family(
    'rhel' => 'php55w-mysqlnd',
    'debian' => 'php5-mysql'
  )
end
