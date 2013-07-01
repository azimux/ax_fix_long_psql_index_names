# I am not sure why, but we get a NameError on ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
# which makes no sense at all to me.rake
raise unless ActiveRecord::Base.connection.class.name =~ /PostgreSQLAdapter/

ActiveRecord::Base.connection.class.class_eval do
  #There are PostgreSQL drivers/versions of drivers that truncate
  #index names to 63 characters. Since some do not, this override makes
  #sure that the truncate occurs regardless of PostgreSQL driver.
  def index_name(table, columns)
    name = super(table, columns)
    if name.size <= 63
      name
    else
      #replace the end of the string with the size of the chopped off part,
      #to reduce the likelyhood of collisions
      ax_truncate_index_name(name)
    end
  end

  def ax_truncate_index_name index_name
    if index_name =~ /^([\w\d_]{63})([\w\d_]+)$/
      size = $2.size.to_s

      $1[0..(62 - size.size)] + size
    else
      index_name
    end
  end
end

# Ugg, more monkey patching
# let's repair broken schema_plus

if defined?(SchemaPlus::ActiveRecord::ColumnOptionsHandler)
  module SchemaPlus::ActiveRecord
    module ColumnOptionsHandler
      def auto_index_name_with_fix_psql_index(*args)
        index_name = auto_index_name_without_fix_psql_index(*args)
        ActiveRecord::Base.connection.ax_truncate_index_name(index_name)
      end
      alias_method_chain :auto_index_name, :fix_psql_index
    end
  end
else
  raise "no schema plus??"
end
