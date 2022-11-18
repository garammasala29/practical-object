# def gear_inches
#   ratio * (rim + (tire * 2))
# end

def gear_inches
  ratio * diameters
end

def diameters
  rim + (tire * 2)
end
