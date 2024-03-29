
module lab8_soc (
	clk_clk,
	key2_wire_export,
	key3_wire_export,
	keycode_export,
	reset_reset_n,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	otg_hpi_w_export,
	otg_hpi_r_export,
	otg_hpi_data_in_port,
	otg_hpi_data_out_port,
	otg_hpi_address_export,
	otg_hpi_cs_export);	

	input		clk_clk;
	input		key2_wire_export;
	input		key3_wire_export;
	output	[15:0]	keycode_export;
	input		reset_reset_n;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	output		otg_hpi_w_export;
	output		otg_hpi_r_export;
	input	[15:0]	otg_hpi_data_in_port;
	output	[15:0]	otg_hpi_data_out_port;
	output	[1:0]	otg_hpi_address_export;
	output		otg_hpi_cs_export;
endmodule
