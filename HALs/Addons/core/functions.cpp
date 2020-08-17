class HALs {
	class Common {
		file = "HALs\Addons\core\functions";
		class log {headerType = -1};
	};

	class Numbers {
		file = "HALs\Addons\core\functions\numbers";
		class numberToString {};
	};

	class Arrays {
		file = "HALs\Addons\core\functions\arrays";
		class sortArray {};
	};

	class Config {
		file = "HALs\Addons\core\functions\config";
		class getConfigClass {headerType=-1;};
		class getConfigValue {headerType=-1;};
		class getModuleSettings {};
	};
};
