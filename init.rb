ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.class_eval do
  #There are PostgreSQL drivers/versions of drivers that truncate
  #index names to 63 characters. Since some do not, this override makes
  #sure that the truncate occurs regardless of PostgreSQL driver.
  def index_name(table, columns)
    super(table, columns)[0..62]
  end
end
