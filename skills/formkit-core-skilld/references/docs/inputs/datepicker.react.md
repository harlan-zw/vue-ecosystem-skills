# Datepicker Input

A Pro input that allows users to select a date via pop up calendar or typing the date in using their preferred localization.

## Basic example

The `datepicker` input allows users to select a date from a customizable calendar, and type the date directly into the input with full internationalization support.

In React JSX props like <code>pickerOnly</code>, <code>valueFormat</code>, and <code>valueLocale</code> use the standard prop casing for that framework.

### Example: Datepicker basic

#### datepicker-basic.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="appointment_date"
              label="Appointment date"
              placeholder="Select a date"
              help="Select a date to book your appointment."
              overlay
              popover
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Modes

FormKit uses a unique masking solution to allow users to type dates into the datepicker input (while limiting the available options to only valid values) or select their date via a calendar input.

### Dual entry

- **Text entry** - By default, users can click or tab into any of the "parts" of the displayed date (month, date, year, etc.) in the text input and type their desired value. Matching values will be displayed with automatic completion. In addition to typing, users can hit the up/down arrow keys to cycle through available options for each segment.
- **Picker entry** - By clicking the "calendar" icon to the right of the input, users can also display a calendar popup to select their date visually:

### Example: Datepicker basic

#### datepicker-dual-mode.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="meeting_date"
              label="Meeting date"
              format={{ date: 'short' }}
              popover
              help="What date should we schedule the meeting?"
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

> **Tip:** To show a placeholder when in dual entry mode, you must enable the mask `overlay`. This is not necessary with `picker-only` enabled. Learn more about [masks and overlays here](/inputs/mask#overlay-colorizing-a-mask).

### Picker only

You can disable the text-entry mechanism and ensure someone uses the datepicker dialog to enter their date by adding the `picker-only` prop. In `picker-only` mode, clicking on the input will open the dialog immediately. Additionally, using an `overlay` is not required for placeholder support:

### Example: Datepicker picker-only

#### datepicker-picker-only.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="conference_date"
              label="Conference date"
              placeholder="Select a date"
              help="When are you hosting your next conference?"
              popover
              pickerOnly
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Date format

The datepicker supports Intl.DateTimeFormat "styled dates", as well as token-based date formats. To change the format displayed to the user, modify the `format` prop.

### Styled formats

If your audience is international, you should consider sticking with "[styled dates](#date-styles)" since they are the most natural date formats in each locale. The default format for a datepicker is `long`.

The `format` prop can accept a simple string like `long` or `medium`, in which case it uses the corresponding `Intl.DateTimeFormat` `dateStyle`. Alternatively, you can provide an object with `date` and `time` properties and their respective `Intl.DateTimeFormat` styles (`{ date: 'long', time: 'short' }`).

### Example: Datepicker style formats

#### datepicker-styles.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="reservation_time"
              label="Reservation time"
              help="Select a date and time to reserve your scuba equipment."
              format={{ date: 'short', time: 'short' }}
              sequence={['day', 'time']}
              overlay
              popover
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### Date styles

Enable any of the following date styles with the `format` prop:

| Format Style | Examples |
| --- | --- |
| full | Wednesday, March 1, 2023, Mercoledì 1 marzo 2023 |
| long | March 1, 2023, 1 marzo 2023 |
| medium | Mar 6, 2023, 6 mar 2023 |
| short | 3/1/23, 1/3/23 |

#### Time styles

| Format style | Examples |
| --- | --- |
| long | 7:05:00 PM, 19:05:00 |
| medium | 7:05:00 PM, 19:05:00 |
| short | 7:05 PM, 19:05 |

### Token formats

You can use the `format` prop to explicitly set a tokenized date format. A token format is represented by a string with any arbitrary characters and one or more of the strings in the table below.

FormKit interfaces with the Intl.DateTimeFormat to automatically internationalize tokens based on the current `locale`. For example, the token `MMMM` for `2000-01-01` would produce `January` for the `en` locale but would produce `一月` for the `zh` locale.

> **Warning:** It is possible, when using tokens, to create non-parsable dates. For example, if your input only displays the day of the week (`dddd`). You can use non-parsable date formats only in `picker-only` mode. If you’d like to allow your users to type in their date, your format must include at least a month, day, and year token.

| Token | Examples | Description |
| --- | --- | --- |
| YY | 99, 23, 00 | 2 digit year |
| YYYY | 1999, 2023, 2100 | 4 digit year |
| M | 1, 12 | The month 1-12 |
| MM | 01, 12 | The month 01-12 |
| MMM | Jan, Feb | Short name Jan-Dec |
| MMMM | January, February | Full name January - December |
| D | 1, 9, 22 | The day of the month 1-31 |
| DD | 01, 09, 22 | The day of the month 01-31 |
| d | M, T, W, T, F, S, S | Single digit day "T" |
| ddd | Thu, Sat | Short day name "Thu" |
| dddd | Monday, Tuesday | Full day name "Wednesday" |
| H | 0, 13, 23 | Minimum hour digits, 24 hour, 0-23 |
| HH | 00, 13, 23 | 2 hour digits, 24 hour, 00-23 |
| h | 12, 1, 11 | Minimum hour digits, 12 hour clock, 1-12 |
| hh | 12, 01, 11 | 2 hour digits, 12 hour clock, 01-12 |
| m | 1, 59 | The minute 0-59 |
| mm | 01, 59 | The minute 00-59 |
| s | 1, 59 | The second 0-59 |
| ss | 01, 59 | The second 00-59 |
| a | am, pm | am/pm |
| A | AM, PM | AM/PM |

> **Tip:** Although FormKit will internationalize your tokens automatically — if your form is intended for a broadly international audience consider using date styles instead of tokens as this leads to a more readable date in many locales.

### Example: Datepicker tokens

#### datepicker-tokens.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="launch"
              label="Product launch date"
              format="MMMM D"
              minDate={new Date()}
              overlay
              popover
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### Escaping tokens

To include letters in the your format that are themselves tokens (like `a`), you can escape those tokens with a backslash `\` before the character:

### Example: Datepicker escape tokens

#### datepicker-escape-tokens.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="checkin"
              format="C\\heckin: MMM D, YYYY"
              minDate={new Date()}
              popover
              overlay
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Panel sequence

The datepicker’s calendar popup has four "panels":

- `day` — Shows a traditional calendar view of a month with each day selectable.
- `month` — Shows the 12 months of the year.
- `year` — Shows a decade of years at a time.
- `time` — Shows the time of day.

When a user opens the datepicker’s popup, they will be shown one or more of these panels. You can modify which panels are displayed to the user and the sequence those panels should be displayed in by providing a `sequence` prop. The default `sequence` value is `['day']` (which allows you to navigate to the `month` and `year` panels).

For example, when selecting a birthday, it is natural to first select the birth year, then the month, then the day. The `sequence` prop allows this behavior:

### Example: Datepicker sequence

#### datepicker-sequence.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="birthday"
              label="Birthday"
              help="Select your birthday"
              placeholder="Select a birthday"
              format="full"
              sequence={['year', 'month', 'day']}
              pickerOnly
              popover
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

### Selecting time

The `time` panel can be used to allow a user to select a specific time of day. If you choose a `format` that includes time (like `YYYY-MM-DD HH:mm`), you’ll likely want to include `time` panel to your sequence:

### Example: Datepicker time

#### datepicker-time.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="reservation"
              label="Dinner reservation"
              help="Select a time for your dinner reservation."
              placeholder="Select a time"
              format="MMM D \\at hh:mm A"
              sequence={['day', 'time']}
              pickerOnly
              popover
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Values

Like all inputs, the `value` of the datepicker is both what is produced by the datepicker, and what is read back into the datepicker for hydration. By default, the format of the value is a UTC-normalized ISO8601 string (example: `2014-11-27T03:59:00.000Z`). However, this format can be changed to any of the supported date style or a token formats [listed above](#date-format) by using the `value-format` prop.

A valid question is why not always use `ISO8601`? Although it’s the most popular way to work with dates — it’s machine *and* human readable — it’s not *very* human readable. For example, if your form sends a contact request email to a catering business, then `ISO8601` would likely not be the best choice.

> **Tip:** The value format must contain all the necessary data to re-constitute a date object, at a minimum this includes month, day, year. If your input requests information from the user that is not represented in your value format, those details will be lost.

### Date styles

To use a date style as the value, pass the style you’d like to use to the `value-format` prop:

### Example: Datepicker style value

#### datepicker-style-value.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="cater_date"
              label="Service date"
              placeholder="Select a date"
              help="When would you like to request catering service?"
              overlay
              popover
              valueFormat={{ date: 'long' }}
              valueLocale="en-US"
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

### Token formats

Values can also be represented in any arbitrary format by using formatting tokens:

### Example: Datepicker token value

#### datepicker-token-value.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="sig_date"
              label="Signature date"
              placeholder="Date of signature"
              overlay
              popover
              valueFormat="\\D\\ay D of MMMM in t\\he ye\\ar YYYY"
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

### Setting values (hydrating)

Values passed to a datepicker must:

1. Match the `value-format` in the current `value-locale` OR,
2. Be a native JavaScript `Date` object.

Although native `Date` objects are always accepted as valid *inputs* for a datepicker, they will be immediately transformed into the `value-format` specified.

#### Matching the value-format

### Example: Datepicker value locale

#### datepicker-matching-value.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="closing_date"
              label="Closing date"
              placeholder="Date of closing"
              help="When did you close on your home?"
              overlay
              popover
              valueFormat="MMM DD YYYY"
              valueLocale="en"
              defaultValue="Feb 28 2019"
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### Using a native Date

### Example: Datepicker value locale

#### datepicker-native-date.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="closing_date"
              label="Closing date"
              placeholder="Date of closing"
              help="When did you close on your home?"
              overlay
              popover
              valueFormat="MMM DD YYYY"
              valueLocale="en"
              defaultValue={new Date('2019-02-28')}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

### Value locale

Since the format of the value needs to be parsed using the same locale it was created with, it is recommended to always specify the `value-locale` when defining a custom `value-format`. This ensures that no matter what the locale of the user entering the date is, the value will stay consistent:

> **Note:** Changing the `value-locale` has no effect on the `timezone` of the date being picked. See the [timezone documentation](#timezone) below for further explanation.

### Example: Datepicker value locale

#### datepicker-value-locale.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="arrival"
              label="Kyiv arrival time"
              help="When will you be arriving in Kyiv?"
              sequence={['day', 'time']}
              format={{ date: 'long', time: 'short' }}
              valueFormat={{ date: 'long', time: 'short' }}
              valueLocale="uk"
              defaultValue="14 березня 2023 р. о 17:02"
              popover
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Timezones

Time is a notoriously hard thing to work with in any software environment, but especially browser-based JavaScript. The `datepicker` provides some options to help work around these challenges.

In order to work with dates and times in JavaScript, it is useful to have a basic understanding of the `Date` object. The date object in JavaScript is fundamentally a Unix timestamp (number of milliseconds since `Jan 1 1970 at 00:00:00Z`). However, it is *always* localized to the client’s time. This localization is expressed in an an offset from `UTC`. Your browser’s current time is:
When the offset is applied to the "clock time" you arrive at the current time in UTC:
When using `value-format` tokens in the datepicker, those tokens will operate using the client’s timezone. For example, if your format requests the `HH` token it would return:
Compare that to the above dates, and you’ll see it is the same as the `hours` portion of the local time. Why does this matter? Read on.
### A case study
Let’s consider a reservation app for a restaurant located in Amsterdam (`UTC +100/+200`). It’s a popular destination for tourists and they often make reservations several weeks before they travel (while in their home country).
The datepicker, by default, will ask the tourist for the date and time of their desired reservation — but (by default) the selection will be their *local* time, not the time in Amsterdam. Even though the `value-format` is outputting UTC, the time will not be the intended reservation time in Amsterdam (unless they happen to be in the same timezone).
Generally speaking, there are 2 solutions to this problem:
#### Option 1: Indeterminate time
Use an "indeterminate" time (sometimes referred to as "wall time"). An indeterminate time is a time without a specific correlation the an underlying Unix Timestamp. For example, `2pm on March 13th` is not UTC and has no explicit offset. `2pm on March 13th` describes a specific time at an indeterminate location/timezone. You can do this with format tokens like (`YYYY-MM-DD HH:mm`) as long as you do not use the offset in your value (`Z`).
This would work for our restaurant app as long as a backend is able to attach an appropriate timezone or offset to this indeterminate time `2023-03-13 14:00 GMT+0100` to arrive at the appropriate UTC time (what this fictitious app requires in its database). The remaining challenge, for a backend developer, is knowing what offset to apply to the date to ensure it becomes "Amsterdam time" (this offset varies based on the time of year due to daylight savings in `Europe/Amsterdam`).
#### Options 2: Using the datepicker’s timezone prop
Alternatively, the `timezone` prop of the datepicker will perform the offset correction for you automatically. State "where" the datepicker is picking time for — in our example `timezone="Europe/Amsterdam"`. The user’s experience will not change at all, but the time they select will be in the target timezone. A user in `America/New_York` (`+0400`) who selects `2pm on March 13th` in their datepicker, will yield a UTC value of `2023-03-13T13:00:00Z` which is `2pm` in Amsterdam. This allows for simple storage and hydration of your date using a `UTC` format.

### Indeterminate timezone

By default, the datepicker uses the client’s local timezone when a selection is made. The value of the output is determined by the `value-format` ([see above](#values)) — by default this is a `UTC` normalized `ISO8601` string. However, by specifying a custom format, you can achieve an "indeterminate" time (also called "wall time"). This is a date and/or time with no specific correlation to a given timezone.

For example, when you set an alarm on your phone for `8:00 AM` — that time is "indeterminate" — it has no correlation to timezone. If you live in Rome, and travel to Tokyo, your alarm will ring at `8:00 AM` in Tokyo the same as it would ring at `8:00 AM` in Rome. It’s impossible to represent a this as UTC.

You can achieve indeterminate time with the datepicker by providing no timezone or offset information in your `value-format` — it is up to the interpreter of the date to add that information. The tokens in a `value-format` always output local client values — so by leaving any timezone or offset (`Z`) data out of the value, it is inherently "indeterminate":

### Example: Datepicker indeterminate

#### datepicker-indeterminate.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="alarm"
              label="Set an alarm"
              help="When should your alarm ring?"
              format={{ time: 'short' }}
              valueFormat="HH:mm"
              sequence={['time']}
              sectionsSchema={{
                panelHeader: {
                  $el: null,
                  children: [],
                },
              }}
              overlay
              popover
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

### Specifying a timezone

For some applications, it is necessary to select the time in a given location — this can be quite challenging. To help ease this pain, the datepicker supports the ability to explicitly specify the `timezone` of the input.

The `timezone` prop lets you specify the "location" of the datepicker based on browser supported IANA timezones. This is important when you’d like to allow users to select a date and time in a given geographic location, no matter what the client’s location is. Some example use cases are:

- Restaurant reservations
- Car rental pickup time
- Hotel check in time

There are plenty of times where the `timezone` should *not* be used (default’s to client time):

- Scheduling a Zoom meeting
- Setting a reminder notification
- Creating a calendar event

In the example below, a user needs to pickup a rental car in Kolkata, India after an international flight. The user looks at their ticket — the flight arrives in Kolkata at `1:45 PM`. They’d like to pick the car up 45 minutes later at `2:30 PM`. These facts are true no matter where in the world the user is booking the trip from. In this case, we should set the timezone to `Asia/Kolkata`. The offset in Kolkata is `+5:30` — so selecting `2:30 PM` in `Kolkata` is equivalent to `09:00 AM` UTC:

### Example: Datepicker timezone

#### datepicker-timezone.react.jsx

```jsx
<h3>Car reservation (CCU Kolkata airport)</h3>
        <div className="rental-car-card" />
        <FormKit
          type="datepicker"
          name="pickup"
          label="Pickup time"
          placeholder="Pickup time"
          format={{ date: 'short', time: 'short' }}
          sequence={['day', 'time']}
          help="Select a date and time to pickup your rental car."
          minDate={new Date()}
          timezone="Asia/Kolkata"
          overlay
          popover
        />
        <FormKit
          type="datepicker"
          name="return"
          label="Return time"
          placeholder="Return time"
          format={{ date: 'short', time: 'short' }}
          sequence={['day', 'time']}
          minDate={new Date()}
          help="Select a date and time to return your rental car."
          timezone="Asia/Kolkata"
          overlay
          popover
        />
```

> **Tip:** Most browsers ship with a comprehensive IANA database built into `Intl.DateTimeFormat`. This is excellent since FormKit does not need to ship the (quite extensive) timezone database to the client’s browser. However, some older browser may not have the IANA database. This data can be polyfilled easily by using polyfill.io with `Intl.DateTimeFormat.~timeZone.all`.

## Disabling dates

It is often necessary to disable specific dates in the datepicker. There are three ways to disable dates in the datepicker:

- `min-date` - a prop to control what the first available date is.
- `max-date` - a prop to control what the last available date is.
- `disabled-dates` - a prop to control whether or not any arbitrary date should be disabled.

Any date that is disabled cannot be selected in the datepicker’s pop up, however an unavailable date can still be set as the initial value or by typing it into the input (when it isn’t in `picker-only` mode). To handle these edge cases the datepicker has a built-in validation rule (that cannot be disabled) that ensures only valid dates can be submitted. The validation rule’s key is `invalidDate`.

### Min date

Often it is necessary to disable dates that are prior to a particular date. For example, booking a hotel room should only happen for dates in the future. To do this, use the `min-date` prop with either an `ISO8601` compatible string or a native `Date` object:

### Example: Datepicker min-date

#### datepicker-min-date.react.jsx

```jsx
<FormKit
        type="datepicker"
        name="pickup"
        label="A future date"
        validationVisibility="live"
        placeholder="Some date in the future"
        pickerOnly
        popover
        minDate={new Date()}
      />
```

### Max date

To disable all dates after a given date, use the `max-date` prop. For example, a birthday selector should only allow past dates. To do this, use the `max-date` prop with either an `ISO8601` compatible string or a native `Date` object:

### Example: Datepicker min-date

#### datepicker-max-date.react.jsx

```jsx
<FormKit
        type="datepicker"
        name="pickup"
        label="A past date"
        placeholder="Some date in the past"
        pickerOnly
        popover
        maxDate={new Date()}
      />
```

> **Tip:** You can use `min-date` and `max-date` at the same time. Not only will this limit the range of dates, but additionally it will limit the available *years* to only valid years when using text entry.

### Disabled days

Often our applications require substantially more granularity when disabling dates than `min-date` and `max-date` allows. The datepicker allows fine-grained control by leveraging the `disabled-days` prop.

The `disabled-days` prop expects a function that is passed 2 arguments: the core node and a `Date` object. The responsibility of the function is to return a boolean indicating if the date is disabled (`true` is disabled).

The `disabled-days` prop supersedes `min-date` and `max-date` — you can choose to re-implement the base functionality by accessing `node.props.minDate` or `node.props.maxDate`.

> **Warning:** It’s important that the provided function is fast and synchronous — it will be called frequently and repeatedly. For example, if you need to fetch information from a database, do it outside of this function and use this function to access memoized results.

#### Example: disabled weekends

### Example: Datepicker disabled weekends

#### datepicker-disabled-days-weekend.react.jsx

```jsx
function disabledDays(node, date) {
  // Re-implement min-date and max-date.
  if (node.props.minDate && date < node.props.minDate) return true
  if (node.props.maxDate && date > node.props.maxDate) return true

  // If the date is a weekend, disable it.
  return date.getDay() === 0 || date.getDay() === 6
}

export default function App() {
  return (
    <>

      <FormKit
        type="datepicker"
        name="pickup"
        label="Next available workday"
        placeholder="Select a workday"
        pickerOnly
        popover
        minDate="2023-01-01"
        maxDate="2025-01-01"
        disabledDays={disabledDays}
      />
```

#### Example: fetch from API

### Example: Datepicker random disabled

#### datepicker-random-disabled.react.jsx

```jsx
const UNAVAILABLE_DATES_URL =
  'https://api-formkit-docs-examples.formkit.workers.dev/blocked-dates'

function Example() {
  const [unavailableDates, setUnavailableDates] = useState([])

  useEffect(() => {
    fetch(UNAVAILABLE_DATES_URL)
      .then((response) => response.json())
      .then((data) => {
        setUnavailableDates(
          data.map(([start, end]) => [new Date(start), new Date(end)])
        )
      })
      .catch((error) => console.error(error))
  }, [])

  function disabledDays(node, date) {
    // Re-implement min-date and max-date.
    if (node.props.minDate && date < node.props.minDate) return true
    if (node.props.maxDate && date > node.props.maxDate) return true

    for (const [start, end] of unavailableDates) {
      if (date >= start && date <= end) return true
    }
    return false
  }

  return (
    <>
      <h3>Bike rental (fetch from API)</h3>
      <FormKit
        type="datepicker"
        name="pickup"
        label="Pickup date."
        placeholder="Select a pickup date"
        help="Select what day you want to pickup your bike"
        minDate={new Date()}
        maxDate={new Date(new Date().setDate(new Date().getDate() + 90))}
        disabledDays={disabledDays}
        popover
        pickerOnly
        slots={{
          day: ({ classes, day, fns, minDate, maxDate }) => (
            <div className={classes.day} style={{ position: 'relative' }}>
              {day.getDate()}
              {fns.isDisabled(day) && day > minDate && day < maxDate ? (
                <div
                  style={{
                    width: '5px',
                    height: '5px',
                    borderRadius: '50%',
                    backgroundColor: 'red',
                    position: 'absolute',
                    bottom: '3px',
                    left: '50%',
                    transform: 'translateX(-50%)',
                  }}
                />
              ) : null}
            </div>
          ),
        }}
      />
    </>
  )
}
```

### Scan for availability

When navigating the calendar pop up via keyboard, the datepicker will not allow you to select a disabled date. However this can be annoying as it can create areas of inaccessibility if some available dates are "sandwiched" between unavailable dates.

To make the user experience better, the datepicker will automatically scan forward or backward (depending on the direction desired) for the next available date to select. The maximum number of days to scan for an available day is controlled by the `maxScan` prop (7 days by default):

#### Example: max-scan

### Example: Datepicker max-scan

#### datepicker-max-scan.react.jsx

```jsx
function disableEvenMonths(_node, date) {
  return date.getMonth() % 2 !== 0
}

export default function App() {
  return (
    <>

      <FormKit
        type="datepicker"
        name="pickup"
        label="Next date"
        placeholder="Select a day"
        help="Use the keyboard to advance past an entire disabled month."
        maxScan={32}
        pickerOnly
        popover
        disabledDays={disableEvenMonths}
      />
```

## Clearable

The datepicker input can be cleared by clicking the "clear" button that appears when the input has a value — this clear button only appears when the `clearable` prop is added:

### Example: Datepicker clearable

#### datepicker-clearable.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="datepicker"
              name="vacation_date"
              label="Time off request"
              help="Please select the date you would like to start your vacation."
              placeholder="Select a date"
              defaultValue={new Date()}
              popover
              clearable
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `clearable` | `string` | `false` | Adds a clear button to the right of the value. This button only appears when the input has a completed value. |
| `date-format` | `string` | `D` | The token format to use in the calendar for dates in the month. |
| `disabled-days` | `function` | `min/max date logic` | A function that is passed the core node and a Date object and must return if the date is disabled (true is disabled). |
| `format` | `string/object` | `date: 'long'` | The format to display to the user in the select input. |
| `max-date` | `Date | ISO8601` | `none` | The maximum date the user is allowed to select. |
| `max-scan` | `number` | `7` | The maximum number of days to scan forward or backward when looking for an available date to jump to via keyboard navigation. |
| `min-date` | `Date | ISO8601` | `none` | The earliest date the user is allowed to select. |
| `month-button-format` | `string` | `MMMM` | The date format token to use for the month panel button in the calendar popup. |
| `month-format` | `string` | `MMMM` | The date format token to use for each of the 12 months on the month panel. |
| `overlay` | `boolean` | `false` | Whether or not to display a mask overlay. Read more about overlays in the mask input documentation (has no effect in pickerOnly` mode). |
| `picker-only` | `boolean` | `false` | Whether or not to allow the date to be entered via text input. When picker-only is enabled, only the picker can be used to select a date. |
| `show-months` | `number` | `1` | The number of months to render in the popup when on the day panel. |
| `sequence` | `array` | `['day']` | The sequence of panels to walk a user through when they open the datepicker calendar view. Options are year, month, day, time. |
| `value-format` | `string/object` | `ISO8601` | The format to record as the value of the input. This can be composed with any token format, date style, or ISO8601. |
| `value-locale` | `string` | `<code>node.props.locale</code>` | The locale to use for the valueFormat. When using format tokens in the valueFormat prop it is highly recommend to set an explicit valueFormat. |
| `week-start` | `number` | `0` | The day of the week to start the day panel’s calendar on. 0-6 where 0 = Sunday and 6 = Saturday. |
| `weekday-format` | `string` | `d` | The date format token used to render the day of the week column headers. |
| `year-format` | `string` | `YYYY` | The date format token used to render the years in the year panel. |
| `popover` | `boolean` | `false` | Renders the input's UI panel using the browser Popover API. |

## Sections & slot data

You can target specific sections of an input using the `section-key` attribute or slots. Each section can be styled or customized independently.

## Slot Data

### Universal Slot Data

Available in all sections of this input:

| Property | Type | Description |
|----------|------|-------------|
| `_value` | `any` | The current  |
| `_root` | `Document | ShadowRoot` | The root document or shadow root the input is inside. This can be set by using a higher-order `<FormKitRoot>` component. |
| `attrs` | `Record<string, any>` | An object of attributes that (generally) should be applied to the root <input> element. |
| `classes` | `Record<string, string>` | Classes to apply on the various sections. |
| `defaultMessagePlacement` | `boolean` | Whether or not to render messages in the standard location. |
| `describedBy` | `string` | The ID of an element that describes the input. This is generally used for screen readers. |
| `didMount` | `boolean` | Whether or not the input has been mounted. |
| `disabled` | `boolean` | Whether the input is disabled. |
| `family` | `string` | The family of the input. This is generally the same as the input type but can be used to group similar inputs for styling purposes. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions, generally for use in the input’s schema. |
| `help` | `string` | The help text of the input |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers. |
| `id` | `string` | The unique id of the input. Should also be applied as the id attribute. This is generally required for accessibility reasons. |
| `items` | `symbol[]` | An array of symbols that represent the a child’s nodes. These are not the child’s nodes but are just symbols representing them. They are used to iterate over the children for rendering purposes. |
| `label` | `string` | The label of the input |
| `messages` | `Record<string, FormKitMessage>` |  A list of messages to be displayed on the input. Often these are validation messages and error messages, but other `visible` core node messages do also apply here. This object is only populated when the validation should be actually displayed. |
| `node` | `FormKitNode` | The cored node of this input. |
| `slots` | `Record<string, CallableFunction>` | A record of slots that have been passed into the top level component responsible for creating the node. |
| `state` | `FormKitFrameworkContextState` | A collection of state trackers/details about the input |
| `type` | `string` | The type of input eg.  |
| `ui` | `Record<string, FormKitMessage>` | Translated ui messages that are not validation related. These are generally used for interface messages like  |
| `value` | `any` | The current committed value of the input. This is the value that should be used for most use cases. The setting of this property is debounced by the value of the debounce prop (default of 20ms). |

### Input-Specific Slot Data

Additional slot data specific to the `datepicker` input:

| Property | Type | Description |
|----------|------|-------------|
| `format` | `string | { date?: string; time?: string }` | The display format for the date (style or token format). |
| `valueFormat` | `string` | The format used for the input value (default: ISO8601). |
| `sequence` | `(` | The sequence of panels shown when opening the picker. |
| `pickerOnly` | `boolean` | Whether text entry is disabled (picker dialog only). |
| `minDate` | `Date | string` | The earliest selectable date. |
| `maxDate` | `Date | string` | The latest selectable date. |
| `decade` | `string` | The decade range displayed in the years panel header. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the datepicker input. |
| `fns.format` | `(date: Date, format: string) => string` | Formats a date according to the given format string. |
| `fns.isDisabled` | `(date: Date) => boolean` | Returns true if the given date is disabled. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the datepicker input. |
| `handlers.open` | `() => void` | Opens the datepicker panel. |
| `handlers.close` | `() => void` | Closes the datepicker panel. |
| `handlers.selectDate` | `(date: Date) => void` | Selects the given date. |
| `handlers.nextPanel` | `() => void` | Navigates to the next panel in the sequence. |
| `handlers.prevPanel` | `() => void` | Navigates to the previous panel in the sequence. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `year` | `year`, `years` | `Date` | The date object for the year being rendered. |
| `month` | `month`, `months` | `Date` | The date object for the month being rendered. |
| `day` | `day`, `dayCell`, `weekDay` | `Date | [number, string, string, string]` | The date object for the day being rendered, or day-of-week tuple for weekDay. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Input structure
The main datepicker input with calendar button.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ input
      └─ openButton
        └─ calendarIcon
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message

#### Overlay structure
Located inside inner when the overlay prop is enabled.
- overlay
  └─ overlayInner
    └─ overlayParts
      └─ overlayPlaceholder
      └─ overlayLiteral
      └─ overlayChar
      └─ overlayEnum

#### Years panel
Panel for selecting a year from a decade.
- panelWrapper
  └─ panelHeader
    └─ prev
      └─ prevLabel
      └─ prevIcon
    └─ yearsHeader
    └─ next
      └─ nextLabel
      └─ nextIcon
  └─ panel
    └─ years
      └─ year

#### Months panel
Panel for selecting a month.
- panelWrapper
  └─ panelHeader
    └─ monthsHeader
      └─ yearButton
    └─ panelClose
      └─ closeIcon
  └─ panel
    └─ months
      └─ month

#### Day panel
Panel for selecting a day from a calendar month.
- panelWrapper
  └─ panelHeader
    └─ prev
      └─ prevIcon
    └─ daysHeader
      └─ monthButton
      └─ yearButton
    └─ next
      └─ nextIcon
    └─ panelClose
      └─ closeIcon
  └─ panel
    └─ calendar
      └─ calendarHeader
        └─ weekDays
          └─ weekDay
      └─ calendarWeeks
        └─ week
          └─ dayCell
            └─ day

#### Time panel
Panel for selecting a time of day.
- panelWrapper
  └─ panelHeader
    └─ timeHeader
      └─ monthButton
      └─ dayButton
      └─ yearButton
    └─ panelClose
      └─ closeIcon
  └─ panel
    └─ time
      └─ timeInput
```

### Section keys

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `label` | `<span>` | A span containing the label text beside the checkbox/radio. |
| `inner` | `<span>` | A span wrapping the input, decorator, prefix, and suffix sections. |
| `prefixIcon` | `<label>` | An element for outputting an icon before the prefix section. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `input` | `<select>` | The native HTML select element. |
| `openButton` | `<button>` | Button that opens the datepicker calendar popup. |
| `calendarIcon` | `<span>` | Calendar icon inside the open button. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `help` | `<div>` | The element containing help text. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |
| `overlay` | `<div>` | Outer wrapper for the overlay used to style different parts of the mask text. |
| `overlayInner` | `<div>` | Inner wrapper immediately inside the overlay section. |
| `overlayParts` | `<div>` | Container for all overlay part elements (iterates over mask parts). |
| `overlayPlaceholder` | `<span>` | Overlay characters of type placeholder (unfilled positions). |
| `overlayLiteral` | `<span>` | Overlay characters of type literal (separators like /, -, etc.). |
| `overlayChar` | `<span>` | Overlay characters of type char (user-entered characters). |
| `overlayEnum` | `<span>` | Overlay characters of type enum (e.g., month names). |
| `panelWrapper` | `<div>` | Wrapper around the panel and panelHeader, responsible for showing/hiding the picker dialog. |
| `panelHeader` | `<div>` | Wrapper around the header of each panel where navigation buttons are located. |
| `prev` | `<button>` | Button to navigate to the previous month or decade. |
| `prevLabel` | `<span>` | Text label inside the prev button. |
| `prevIcon` | `<span>` | Icon inside the prev button. |
| `yearsHeader` | `<span>` | Header showing the decade range (e.g., |
| `next` | `<button>` | Button to navigate to the next month or decade. |
| `nextLabel` | `<span>` | Text label inside the next button. |
| `nextIcon` | `<span>` | Icon inside the next button. |
| `panel` | `<div>` | The color picker panel containing all controls. |
| `years` | `<div>` | Container for the decade of year buttons. |
| `year` | `<button>` | Individual year button in the years panel. |
| `monthsHeader` | `<div>` | Header wrapper on the months panel containing the year button. |
| `yearButton` | `<button>` | Button in panel header that navigates to the year panel. |
| `panelClose` | `<button>` | Close button for the panel (shown on small screens). |
| `closeIcon` | `<span>` | Icon for the search clear button. |
| `months` | `<div>` | Container for the 12 month buttons. |
| `month` | `<button>` | Individual month button in the months panel. |
| `daysHeader` | `<div>` | Header on the day panel with month and year buttons. |
| `monthButton` | `<button>` | Button in panel header that navigates to the month panel. |
| `calendar` | `<div>` | Wrapper around the calendar on the day panel. |
| `calendarHeader` | `<div>` | Header row showing days of the week. |
| `weekDays` | `<div>` | Wrapper around the day-of-week column headers. |
| `weekDay` | `<span>` | Individual day-of-week header cell (S, M, T, W, etc.). |
| `calendarWeeks` | `<div>` | Container for all week rows. |
| `week` | `<div>` | A single row of 7 days. |
| `dayCell` | `<div>` | Wrapper around an individual day button. |
| `day` | `<button>` | Individual day button showing the numeric date. |
| `timeHeader` | `<div>` | Header on the time panel with month, day, and year buttons. |
| `dayButton` | `<button>` | Button in time panel header that navigates to the day panel. |
| `time` | `<div>` | Wrapper for the time panel content. |
| `timeInput` | `<input>` | Native HTML time input for selecting time. |

## Accessibility

All FormKit inputs are designed with the following accessibility considerations in mind. Help us continually improve accessibility for all by filing accessibility issues here:

- ✓ Semantic markup
- ✓ ARIA attributes
- ✓ Keyboard accessibility
- ✓ Focus indicators
- ✓ Color contrast with the provided theme
- ✓ Accessible labels, help text, and errors

### Accessibility attributes

| Section | Attribute | Value | Description |
|---------|-----------|-------|-------------|
| `panelWrapper` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `panelWrapper` | `aria-modal` | `true` | Indicates the modal dialog is present and it blocks interaction with other elements on the page. |
| `panelWrapper` | `aria-label` | `-` | Provides an accessible name. |
| `weekDay` | `aria-label` | `-` | Provides an accessible name. |
| `dayCell` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to 0 when its the same day and -1 when its not. |
| `dayCell` | `aria-selected` | `-` | Indicates whether the day is currently selected. |
| `dayCell` | `aria-label` | `-` | Provides an accessible name. |
| `openButton` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when its in picker only mode and 0 when its not. |
| `openButton` | `aria-label` | `-` | Provides an accessible name. |
| `openButton` | `aria-haspopup` | `true` | Signals the presence of a pop-up menu or dialog triggered by this interaction. |
| `openButton` | `aria-expanded` | `-` | Indicates whether the colorpicker element is currently expanded or collapsed. |
| `openButton` | `aria-controls` | `-` | Links this element to the ID of the listbox element. |
| `year` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to 0 when its the same year and -1 when its not. |
| `year` | `aria-selected` | `-` | Indicates whether the year is currently selected. |
| `month` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to 0 when its the same month and -1 when its not. |
| `month` | `aria-selected` | `-` | Indicates whether the month is currently selected. |
| `panelHeader` | `aria-live` | `polite` | Annouces to screen readers that this element was dynamically updated without interrupting the current task. |
| `dayButton` | `tabindex` | `2` | Prioritizes keyboard focus order by setting it to 2. |
| `removeSelection` | `aria-controls` | `-` | Links this element to the ID of the input element. |
| `panelClose` | `tabindex` | `-1` | Prioritizes keyboard focus order by setting it to -1. |
| `panelClose` | `aria-label` | `-` | Provides an accessible name. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `esc` | Closes the browser date picker panel. |
| `up` + `down` + `left` + `right` | Adjusts selection of UI elements in browser date picker panel. |
