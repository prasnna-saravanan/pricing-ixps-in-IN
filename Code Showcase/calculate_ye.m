function y_e_func = calculate_ye(n, ixp_data_y, ixp_data_lambda)
    % Check if there are enough unique data points for interpolation
    if numel(unique(ixp_data_y)) < 2
        y_e_func = @(beta) NaN;  % Return NaN for all beta values
    else
        % Define a function handle to calculate y_e for given beta
        y_e_func = @(beta) find_ye_for_beta(beta, n, ixp_data_y, ixp_data_lambda);
    end
end

function y_e = find_ye_for_beta(beta, n, ixp_data_y, ixp_data_lambda)
    % This function performs the interpolation and calculates y_e
    try
        target_lambda = interp1(ixp_data_y, ixp_data_lambda, beta, 'linear', 'extrap');
        y_e = (target_lambda / beta)^(1/n);
    catch
        y_e = NaN;  % Return NaN if interpolation fails
    end
end
