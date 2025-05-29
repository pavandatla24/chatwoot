export const VARIANT_OPTIONS = ['solid', 'outline', 'faded', 'link', 'ghost'];
export const COLOR_OPTIONS = ['woot', 'blue', 'ruby', 'amber', 'slate', 'teal'];
export const SIZE_OPTIONS = ['xs', 'sm', 'md', 'lg'];
export const JUSTIFY_OPTIONS = ['start', 'center', 'end'];

export const EXCLUDED_ATTRS = [
  'variant',
  'color',
  'size',
  'icon',
  'trailingIcon',
  'isLoading',
  ...VARIANT_OPTIONS,
  ...COLOR_OPTIONS,
  ...SIZE_OPTIONS,
  ...JUSTIFY_OPTIONS,
];

export const STYLE_CONFIG = {
  colors: {
    woot: {
      solid:
        'bg-woot-500 text-white hover:bg-woot-600 active:bg-woot-600 focus:outline-woot-400',
      outline:
        'outline-woot-400 text-woot-500 hover:text-woot-600 active:text-woot-600',
      ghost: 'text-woot-500 hover:bg-woot-50 active:bg-woot-50',
      link: 'text-woot-500 hover:underline active:underline',
      faded: 'bg-woot-50 text-woot-500 hover:bg-woot-100 active:bg-woot-100',
    },
    blue: {
      solid:
        'bg-primary-600 text-white hover:bg-primary-700 active:bg-primary-700 focus:outline-primary-400',
      outline:
        'outline-primary-400 text-primary-600 hover:text-primary-600 active:text-primary-600',
      ghost: 'text-primary-600 hover:bg-primary-50 active:bg-primary-50',
      link: 'text-primary-600 hover:underline active:underline',
      faded:
        'bg-primary-50 text-primary-600 hover:bg-primary-100 active:bg-primary-100',
    },
    slate: {
      solid:
        'bg-n-slate-11 text-white hover:bg-n-slate-12 active:bg-n-slate-12 focus:outline-n-slate-8',
      outline:
        'outline-n-slate-6 text-n-slate-11 hover:text-n-slate-12 active:text-n-slate-12',
      ghost: 'text-n-slate-11 hover:bg-n-slate-3 active:bg-n-slate-3',
      link: 'text-n-slate-11 hover:underline active:underline',
      faded:
        'bg-n-slate-3 text-n-slate-11 hover:bg-n-slate-4 active:bg-n-slate-4',
    },
    ruby: {
      solid:
        'bg-ruby-600 text-white hover:bg-ruby-700 active:bg-ruby-700 focus:outline-ruby-400',
      outline:
        'outline-ruby-400 text-ruby-600 hover:text-ruby-600 active:text-ruby-600',
      ghost: 'text-ruby-600 hover:bg-ruby-50 active:bg-ruby-50',
      link: 'text-ruby-600 hover:underline active:underline',
      faded: 'bg-ruby-50 text-ruby-600 hover:bg-ruby-100 active:bg-ruby-100',
    },
    amber: {
      solid:
        'bg-amber-600 text-white hover:bg-amber-700 active:bg-amber-700 focus:outline-amber-400',
      outline:
        'outline-amber-400 text-amber-600 hover:text-amber-600 active:text-amber-600',
      ghost: 'text-amber-600 hover:bg-amber-50 active:bg-amber-50',
      link: 'text-amber-600 hover:underline active:underline',
      faded:
        'bg-amber-50 text-amber-600 hover:bg-amber-100 active:bg-amber-100',
    },
  },
  sizes: {
    regular: {
      xs: 'h-7 px-2',
      sm: 'h-8 px-3',
      md: 'h-10 px-4',
      lg: 'h-12 px-6',
    },
    iconOnly: {
      xs: 'h-7 w-7',
      sm: 'h-8 w-8',
      md: 'h-10 w-10',
      lg: 'h-12 w-12',
    },
    link: {
      xs: 'h-7',
      sm: 'h-8',
      md: 'h-10',
      lg: 'h-12',
    },
  },
  fontSize: {
    xs: 'text-xs',
    sm: 'text-sm',
    md: 'text-sm font-medium',
    lg: 'text-base',
  },
  justify: {
    start: 'justify-start',
    center: 'justify-center',
    end: 'justify-end',
  },
  base: 'inline-flex items-center min-w-0 gap-2 transition-all duration-200 ease-in-out border-0 rounded-lg outline-1 outline disabled:opacity-50',
};
