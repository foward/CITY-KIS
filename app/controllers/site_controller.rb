class SiteController < ApplicationController

  def index
     @title = "CityKis- The Virtual Community"

  end

  def about
     @title = "CityKis-The Virtual Community- About"
  end

  def help
    @title = "CityKis-The Virtual Community- help"
  end

  def agb
    @title = "CityKis-The Virtual Community- AGB"
  end

  def impressum
    @title = "CityKis-The Virtual Community- Impresum"
  end
  
   def kisconnect
    @title = "CityKis-The Virtual Community- KIS-CONNECT"
  end
  
   def kisshuttle
    @title = "CityKis-The Virtual Community- KIS-SHUTTLE"
  end
  
  def kissite
    @title = "CityKis-The Virtual Community- KIS-SITE"
  end
  
   def contact
    @title = "CityKis-The Virtual Community- CONTACT"
  end
  
end



