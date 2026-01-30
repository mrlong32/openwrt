// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
/dts-v1/;

#include "qca956x.dtsi"

/ {
	compatible = "csac,qca9563-csac", "qca,qca9563";
	model = "CSAC Router (QCA9563+QCA8337+QCA9886)";

	chosen {
		bootargs = "console=ttyS0,115200n8";
	};

	aliases {
		led-boot = &led_system;
		led-failsafe = &led_system;
		led-running = &led_system;
		led-upgrade = &led_system;
		label-mac-device = &eth0;
	};

	leds {
		compatible = "gpio-leds";

		led_system: system {
			label = "green:system";
			gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
			default-state = "on";
		};

		wlan2g {
			label = "green:wlan2g";
			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
			linux,default-trigger = "phy1tpt";
		};
	};

	keys {
		compatible = "gpio-keys";

		reset {
			label = "reset";
			linux,code = <KEY_RESTART>;
			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
			debounce-interval = <60>;
		};
	};
};

&spi {
	status = "okay";
	num-cs = <1>;

	flash@0 {
		compatible = "jedec,spi-nor";
		reg = <0>;
		spi-max-frequency = <25000000>;

		partitions {
			compatible = "fixed-partitions";
			#address-cells = <1>;
			#size-cells = <1>;

			partition@0 {
				label = "u-boot";
				reg = <0x000000 0x020000>;
				read-only;
			};

			partition@20000 {
				label = "u-boot-env";
				reg = <0x020000 0x010000>;
				read-only;
			};

			partition@30000 {
				label = "firmware";
				reg = <0x030000 0xfa0000>;
				compatible = "openwrt,uimage", "denx,uimage";
			};

			partition@fd0000 {
				label = "art";
				reg = <0xfd0000 0x010000>;
				read-only;

				nvmem-layout {
					compatible = "fixed-layout";
					#address-cells = <1>;
					#size-cells = <1>;

					macaddr_art_0: macaddr@0 {
						compatible = "mac-base";
						reg = <0x0 0x6>;
						#nvmem-cell-cells = <1>;
					};

					cal_art_1000: calibration@1000 {
						reg = <0x1000 0x440>;
					};
				};
			};
		};
	};
};

&mdio0 {
	status = "okay";

	switch0: switch@1f {
		compatible = "qca,qca8337";
		reg = <0x1f>;
		reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>;

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				reg = <0>;
				label = "lan1";
				phy-handle = <&swphy0>;
			};

			port@1 {
				reg = <1>;
				label = "lan2";
				phy-handle = <&swphy1>;
			};

			port@2 {
				reg = <2>;
				label = "lan3";
				phy-handle = <&swphy2>;
			};

			port@3 {
				reg = <3>;
				label = "lan4";
				phy-handle = <&swphy3>;
			};

			port@4 {
				reg = <4>;
				label = "wan";
				phy-handle = <&swphy4>;
			};

			port@5 {
				reg = <5>;
				label = "cpu";
				ethernet = <&eth0>;
				phy-mode = "sgmii";

				fixed-link {
					speed = <1000>;
					full-duplex;
				};
			};
		};
	};
};

&eth0 {
	status = "okay";
	phy-mode = "sgmii";
	pll-data = <0x03000101 0x00000101 0x00001919>;

	nvmem-cells = <&macaddr_art_0 0>;
	nvmem-cell-names = "mac-address";

	fixed-link {
		speed = <1000>;
		full-duplex;
	};
};

&pcie {
	status = "okay";

	wifi@0,0 {
		compatible = "qcom,ath10k";
		reg = <0x0000 0 0 0 0>;
		nvmem-cells = <&cal_art_1000>;
		nvmem-cell-names = "calibration";
	};
};
