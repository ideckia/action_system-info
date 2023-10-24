# Action for [ideckia](https://ideckia.github.io/): system-info

## Description

Shows the information about the system (powered by [systeminformation.io](https://systeminformation.io/))

## Properties

| Name | Type | Description | Shared | Default | Possible values |
| ----- |----- | ----- | ----- | ----- | ----- |
| info_of | String | Show information of... | false | "battery" | ["battery", "cpu_temperature", "memory"] |
| update_interval | UInt | Update interval in seconds | false | 60 | null |

## On single click

Forces the update of the information

## On long press

nothing

## Test the action

There is a script called `test_action.js` to test the new action. Set the `props` variable in the script with the properties you want and run this command:

```
node test_action.js
```

## Example in layout file

```json
{
    "text": "system-info example",
    "bgColor": "00ff00",
    "actions": [
        {
            "name": "system-info",
            "props": {
                "info_of": "battery",
                "update_interval": 60
            }
        }
    ]
}
```
