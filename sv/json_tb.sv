/*
 * Copyright 2021 Alexander Preissner
 * SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
 *
 * Licensed under the Solderpad Hardware License v 2.1 (the “License”);
 * you may not use this file except in compliance with the License, or, at your
 * option, the Apache License version 2.0.
 * You may obtain a copy of the License at
 *
 * https://solderpad.org/licenses/SHL-2.1/
 *
 * Unless required by applicable law or agreed to in writing, any work
 * distributed under the License is distributed on an “AS IS” BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module json_tb;

    import uvm_pkg::*;
    import json::*;

    `include "uvm_macros.svh"
    `include "json.svh"


	class TestWikipediaExample extends uvm_test;
		`uvm_component_utils(TestWikipediaExample)

        local string id;

		function new (string name = "TestWikipediaExample", uvm_component parent = null);
			super.new(name, parent);
            id = $sformatf("%d: %s", get_inst_id(), get_name());
		endfunction

		virtual function void build_phase (uvm_phase phase);
			super.build_phase(phase);

			// e0 = Environment::type_id::create("e0", this);

			// if (!uvm_config_db#(virtual register_if)::get(this, "", "dut_if", m_if)) begin
			// 	`uvm_fatal("DRIVER", "Did not get interface handle")
			// end
		endfunction

		virtual task run_phase (uvm_phase phase);
            string s, t;
            /* Special string class that extends the SystemVerilog string
            * with some capabilitites that C++ STL strings have */
            util::String r_str;
            Object root;
            Object waehrung, deckung, inhaber, alter, hobbys, golfen, o;
            Array a;

            uvm_report_info(id, $sformatf("%s started", get_name()));

            /* Load the JSON object tree from JSON formatted file */
            root = json::Load("../../../json.json");
            assert (root != null)
                else uvm_report_fatal(id, "Loading data from file failed");

            /* Dump the JSON string and print it as a log message */
            r_str = new();
            root.dumpS(r_str);
            $display(r_str.get());

            /* Object getter examples */
            waehrung = root.getByKey("Waehrung"); /* Get child object by key */
            assert (waehrung != null);
            assert (waehrung.asString() == "EURO");
            deckung  = root.getByKey("Deckung");
            inhaber  = root.getByKey("Inhaber");
            hobbys   = inhaber.getByKey("Hobbys");
            golfen   = hobbys.getByIndex(1); /* Get array element by index */
            alter    = inhaber.getByKey("Alter");

            /* Object / tree manipulation examples */
            root.delete("Nummer"); /* Delete child object */
            $cast(a, hobbys);
            a.delete(1); /* Delete array element */
            a = Array::new(); /* Create new array object */
            a.append(Boolean::new(0)); /* Append new objects to array */
            a.append(Number::new(42));
            a.append(String::new("Hallo Welt!"));
            root.append("Sonstiges", a); /* Append array as a child object */

            /* Dump the manipulated JSON object tree */
            r_str = new();
            root.dumpS(r_str);
            $display(r_str.get());

            /* Object attribute query methods */
            $display("%b", hobbys.isArray());
            $display("%b", root.isTrue());
            $display("%b", root.isNull());
            $display("%d", a.size());
            $display("%s", waehrung.asString());
            $display("%f", deckung.asReal());
            $display("Alter: %d", alter.asInt());

            /* Write the manipulated JSON object tree out to a file */
            root.dump("./json_out.json");
		endtask

	endclass


    class CommandNameCallback extends Callback;
        function automatic void apply (
            Object cmd
        );
            $display("Command: %s", cmd.getByKey("command").asString());
        endfunction
    endclass : CommandNameCallback

	class TestCommandList extends uvm_test;
		`uvm_component_utils(TestCommandList)

		function new (string name = "TestCommandList", uvm_component parent = null);
			super.new(name, parent);
		endfunction

		virtual function void build_phase (uvm_phase phase);
			super.build_phase(phase);
		endfunction

		virtual task run_phase (uvm_phase phase);
            util::String r_str;
            Array root;
            Object first_cmd;
            CommandNameCallback cb = new();

            root = Array'(json::Load("../../../json/cmd.json"));
            $display("Size: %d", root.size());

            first_cmd = root.getByIndex(0).getByKey("command");

            `foreach_object_in_array(cmd, root) begin
                $display("Command: %s", cmd.getByKey("command").asString());
            end

            root.for_each(cb);

            r_str = new();
            root.dumpS(r_str);
            $display(r_str.get());
		endtask

	endclass


    initial
    begin
        run_test();
    end

endmodule
