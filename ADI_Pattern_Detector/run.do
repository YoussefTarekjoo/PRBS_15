vlib work
vlog PRBS.V Patter_Detector.v Data_collect.v TOP_PRBS.V TOP_tb.v +cover -covercells
vsim -voptargs=+acc work.TOP_tb -cover
add wave *
coverage save PRBS.ucdb -onexit
run -all
#quit -sim 
#vcover report PRBS.ucdb -details -annotate -all -output coverage.txt