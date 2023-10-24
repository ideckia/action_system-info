// https://systeminformation.io/

@:jsRequire('systeminformation')
extern class SystemInformationJs {
	static function battery():js.lib.Promise<BatteryInfo>;
	static function cpu():js.lib.Promise<CpuInfo>;
	static function cpuTemperature():js.lib.Promise<CpuTemperature>;
	static function mem():js.lib.Promise<MemoryInfo>;
}

// @:jsRequire('systeminformation', 'cpuTemperature')
// extern class CpuTemperatureJs {}

typedef BatteryInfo = {
	var hasBattery:Bool; // true,
	var cycleCount:Int; // 35,
	var isCharging:Bool; // false,
	var designedCapacity:Int; // 64958,
	var maxCapacity:Int; // 65865,
	var currentCapacity:Int; // 64856,
	var voltage:Float; // 12.767,
	var capacityUnit:String; // 'mWh',
	var percent:Int; // 100,
	var timeRemaining:Float; // 551,
	var acConnected:Bool; // false,
	var type:String; // 'Li-ion',
	var model:String; // '',
	var manufacturer:String; // 'Apple',
	var serial:String; // 'F9Y19860Y9AH9XBAX'
}

typedef CpuTemperature = {
	var main:UInt; // 70,
	var cores:Array<UInt>; // [64, 65, 60, 69],
	var max:UInt; // 70,
	// var socket:Array<UInt>; // [],
	// var chipset:String; // null
}

typedef CpuInfo = {
	var manufacturer:String; // 'Intel®',
	var brand:String; // 'Core™ i9-9900',
	var vendor:String; // 'GenuineIntel',
	var family:String; // '6',
	var model:String; // '158',
	var stepping:String; // '13',
	var revision:String; // '',
	var voltage:String; // '',
	var speed:Float; // 3.1,
	var speedMin:Float; // 0.8,
	var speedMax:Int; // 5,
	var governor:String; // 'powersave',
	var cores:Int; // 16,
	var physicalCores:Int; // 8,
	var processors:Int; // 1,
	var socket:String; // 'LGA1151',
	var flags:String; // 'fpu vme de pse ...',
	var virtualization:Bool; // true,
	var cache:{
		var l1d:Int;
		var l1i:Int;
		var l2:Int;
		var l3:Int;
	}; // { l1d: 262144, l1i: 262144, l2: 2097152, l3: 16777216 }
}

typedef MemoryInfo = {
	var total:UInt; // 67092135936,
	var free:UInt; // 65769291776,
	var used:UInt; // 1322844160,
	var active:UInt; // 1032495104,
	var available:UInt; // 66059640832,
	var buffers:UInt; // 63213568,
	var cached:UInt; // 800124928,
	var slab:UInt; // 268804096,
	var buffcache:UInt; // 1132142592,
	var swaptotal:UInt; // 8589930496,
	var swapused:UInt; // 0,
	var swapfree:UInt; // 8589930496
}
