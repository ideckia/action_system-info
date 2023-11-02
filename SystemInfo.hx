package;

using api.IdeckiaApi;

typedef Props = {
	@:editable('Show information of...', 'battery', ['battery', 'cpu_temperature', 'memory'])
	var info_of:String;
	@:editable("Update interval in seconds", 60)
	var update_interval:UInt;
}

@:name("system-info")
@:description("Shows the information about the system")
class SystemInfo extends IdeckiaAction {
	var updateTimer:haxe.Timer;

	function newTimer(state:ItemState) {
		if (updateTimer == null) {
			updateTimer = new haxe.Timer(props.update_interval * 1000);
			updateTimer.run = () -> {
				update(state).then(newState -> server.updateClientState(newState));
			};
		}
	}

	override public function init(initialState:ItemState):js.lib.Promise<ItemState> {
		return show(initialState);
	}

	override function show(currentState:ItemState):js.lib.Promise<ItemState> {
		return new js.lib.Promise((resolve, reject) -> {
			newTimer(currentState);
			update(currentState).then(resolve);
		});
	}

	override public function hide():Void {
		if (updateTimer != null) {
			updateTimer.stop();
			updateTimer = null;
		}
	}

	public function execute(currentState:ItemState):js.lib.Promise<ActionOutcome> {
		newTimer(currentState);
		return new js.lib.Promise((resolve, reject) -> {
			update(currentState).then(s -> resolve(new ActionOutcome({state: s})));
		});
	}

	function update(state:ItemState) {
		return new js.lib.Promise((resolve, reject) -> {
			switch props.info_of {
				case 'battery':
					getBatteryInfo(state).then(resolve);
				case 'cpu_temperature':
					getCpuTemperature(state).then(resolve);
				case 'memory':
					getMemoryInfo(state).then(resolve);
				case i:
					state.text = 'Can\'t get info about [$i]';
					resolve(state);
			}
		});
	}

	function getBatteryInfo(state:ItemState):js.lib.Promise<ItemState> {
		return new js.lib.Promise((resolve, reject) -> {
			SystemInformationJs.battery().then(batteryInfo -> {
				var timeRemaining = batteryInfo.timeRemaining;
				var timeRemaininString = '-';
				if (timeRemaining != null) {
					var hours = Math.floor(timeRemaining / 60);
					var minutes = timeRemaining - hours * 60;
					var hourString = (hours < 10) ? '0$hours' : '$hours';
					var minutesString = (minutes < 10) ? '0$minutes' : '$minutes';
					timeRemaininString = '$hourString:$minutesString';
				}

				var text = 'Battery:\n';
				text += new RichString('%${batteryInfo.percent}').bold() + '\n';
				text += (batteryInfo.acConnected) ? 'Charging' : timeRemaininString;
				state.text = text;
				resolve(state);
			});
		});
	}

	function getCpuTemperature(state:ItemState):js.lib.Promise<ItemState> {
		return new js.lib.Promise((resolve, reject) -> {
			SystemInformationJs.cpuTemperature().then(cpuTemperature -> {
				var text = 'CPU temp.:\n';
				text += new RichString('${cpuTemperature.main} ºC').bold();
				state.text = text;
				resolve(state);
			});
		});
	}

	function getMemoryInfo(state:ItemState):js.lib.Promise<ItemState> {
		return new js.lib.Promise((resolve, reject) -> {
			SystemInformationJs.mem().then(memoryInfo -> {
				var text = 'Memory:\n';
				var divisor = 10000000;
				var memTotal = Math.round(memoryInfo.total / divisor);
				var totalGb = memTotal / 100;
				var memActive = Math.round(memoryInfo.active / divisor);
				var activeGb = memActive / 100;
				var memPercent = Math.round((activeGb / totalGb) * 10000);
				var percent = memPercent / 100;
				text += new RichString('${activeGb} GB / ${totalGb} GB\n(%${percent})').bold();
				state.text = text;
				resolve(state);
			});
		});
	}
}
