function ixp_data = loadIXPData(data,ixp_id)
    % Filter data for the specific IXP ID
    ixp_data_raw = data(data.ix_id == ixp_id, :);

    % Process data
    sorted_d_ij = sort(ixp_data_raw.d_ij, 'ascend');
    cumsum_b_ij = cumsum(ixp_data_raw.b_ij_split);
    
    % Normalize the data
    max_b_ij = max(cumsum_b_ij);
    % if max_b_ij == 0 | any(isnan(sorted_d_ij)) | any(isinf(sorted_d_ij)) | any(isnan(cumsum_b_ij)) | any(isinf(cumsum_b_ij))
    %     error('Invalid data for IXP ID %d. Please check the dataset for NaNs, Infs, or other irregularities.', ixp_id);
    % end
    
    normalized_cumsum_b_ij = cumsum_b_ij / max_b_ij;
    [ixp_data_y, unique_idx] = unique(sorted_d_ij / max(sorted_d_ij));
    ixp_data_lambda = normalized_cumsum_b_ij(unique_idx);

    % Store the processed data in a structure to return
    ixp_data.normalized_sorted_d_ij = ixp_data_y;
    ixp_data.normalized_cumsum_b_ij = ixp_data_lambda;
end
