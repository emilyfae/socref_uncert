require 'Datavyu_API.rb'

begin


  data = []
  phasecodes = []
  referencecodes = []

  projName = $pj.getProjectName

  output_name = "/Volumes/Experiments/SOC_REF_uncertainty/datavyu/data/" + projName + ".csv"

  phases = getVariable("phase")
  references = getVariable("reference")

  def print_cell_codes(cell)
  s = Array.new
  s << cell.ordinal.to_s
  s << cell.onset.to_s
  s << cell.offset.to_s
  for arg in cell.arglist
    s << cell.get_arg(arg)
  end
  return s
  end

  for phase in phases.cells
    phasecodes = print_cell_codes(phase)

        reference = references.cells.find { |x| x.ordinal.to_i == phase.ordinal.to_i }
        referencecodes = print_cell_codes(reference)

      data << [phasecodes + referencecodes]
  end


  outfile = File.new(output_name, "w+")
  outfile.puts "phase.ordinal,phase.onset,phase.offset,phase.1_2_3_4,reference.ordinal,reference.onset,reference.offset,reference.num_looks,reference.exclude"

  data.each do |row|
    outfile.puts row.join(",")
  end

outfile.close
puts "Finished!"


end
