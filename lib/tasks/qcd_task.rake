namespace :qcds do
  desc "actualizar qcd cada noche"
  task :fetch => :environment do
    @qcd = Qcd.where(:estados => 1)
    @qcd.each do |qcd|
        if qcd != nil
            if DateTime.now > qcd.fecha  
              qcd.estados = 2
              qcd.save
            end
        end
    end
    puts "#{Time.now} - Success!"
  end
end