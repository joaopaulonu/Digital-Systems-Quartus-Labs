transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/jpnun/Documents/Lab 06/circuito_lab06.vhd}

vcom -93 -work work {C:/Users/jpnun/Documents/Lab 06/circuito_lab06.vhd}
vcom -93 -work work {C:/Users/jpnun/Documents/Lab 06/tb_circuito_lab06.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  tb_circuito_lab06

add wave *
view structure
view signals
run -all
