# avoids printing when the tests are running
class SeedPrinter
    def self.call(string)
        puts string unless Rails.env.test?
    end
end
  