

<llm-exclude>

<SlotsTable :data="[
  {
    'name': 'date',
    'description': '',
    'type': 'DateValue'
  },
  {
    'name': 'grid',
    'description': '',
    'type': 'Grid<DateValue>[]'
  },
  {
    'name': 'weekDays',
    'description': '',
    'type': 'string[]'
  },
  {
    'name': 'weekStartsOn',
    'description': '',
    'type': '0 | 1 | 2 | 3 | 4 | 5 | 6'
  },
  {
    'name': 'locale',
    'description': '',
    'type': 'string'
  },
  {
    'name': 'fixedWeeks',
    'description': '',
    'type': 'boolean'
  }
]" />
</llm-exclude>

<llm-only>

**Slots**

| Name | Description | Type |
| --- | --- | --- |
| `date` |  | `DateValue` |
| `grid` |  | `Grid<DateValue>[]` |
| `weekDays` |  | `string[]` |
| `weekStartsOn` |  | `0 \| 1 \| 2 \| 3 \| 4 \| 5 \| 6` |
| `locale` |  | `string` |
| `fixedWeeks` |  | `boolean` |

</llm-only>
