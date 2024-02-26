local UNITS = {
	['s'] = 1,
	['ms'] = 1000,
	['mus'] = 1000000,
	['ns'] = 1000000000
}

local DEFAULT_OPTIONS = {
	name = '',
	unit = 'ms',
	decimals = 2,
	iterations = 10000,
}

local Benchmark = function(name, func, options, ...)
	options = options or {}

	local unit = options.unit or DEFAULT_OPTIONS.unit
	local decimals = options.decimals or DEFAULT_OPTIONS.decimals
	local iterations = options.iterations or DEFAULT_OPTIONS.iterations

	local elapsed = 0
	local multiplier = UNITS[unit]

	for i = 1, iterations do
		local now = os.clock()
		func(...)
		elapsed = elapsed + (os.clock() - now)
	end

	print(string.format('[%s] Benchmark results:\n  - %d function calls\n  - %.' .. decimals .. 'f%s elapsed\n  - %.' .. decimals .. 'f%s avg execution time', name, iterations, elapsed * multiplier, unit, (elapsed / iterations) * multiplier, unit))
end

return Benchmark