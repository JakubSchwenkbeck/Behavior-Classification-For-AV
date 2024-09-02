function EvaluateModel(net, testData, testLabels)
    % EvaluateModel - Evaluate the performance of the trained RNN model
    %
    % This function takes a trained RNN model and test data, evaluates its
    % performance, and generates various metrics and plots to analyze how
    % well the model is performing.
    %
    % Inputs:
    %   net        - The trained RNN model
    %   testData   - The data used for testing the model
    %   testLabels - The actual labels for the test data
    %
    % Outputs:
    %   This function does not return any values, but it displays various
    %   plots and metrics.
    %
    % Example:
    %   EvaluateModel(net, testData, testLabels);
    %

    % Perform predictions on the test data
    predictedLabels = classify(net, testData);

    % Calculate accuracy
    accuracy = sum(predictedLabels == testLabels) / numel(testLabels);
    fprintf('Model Accuracy: %.2f%%\n', accuracy * 100);

    % Confusion matrix
    figure;
    cm = confusionchart(testLabels, predictedLabels);
    cm.Title = 'Confusion Matrix';
    cm.RowSummary = 'row-normalized';
    cm.ColumnSummary = 'column-normalized';

    % Plot ROC curve
    figure;
    [X, Y, T, AUC] = perfcurve(testLabels, predictedLabels, 1);
    plot(X, Y, 'LineWidth', 2);
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    title(sprintf('ROC Curve (AUC = %.2f)', AUC));
    grid on;

    % Precision-Recall curve
    figure;
    [prec, rec, ~] = precisionRecallCurve(testLabels, predictedLabels);
    plot(rec, prec, 'LineWidth', 2);
    xlabel('Recall');
    ylabel('Precision');
    title('Precision-Recall Curve');
    grid on;

    % Display classification report (precision, recall, F1-score)
    classificationReport(testLabels, predictedLabels);

end

function classificationReport(actualLabels, predictedLabels)
    % classificationReport - Generate and display precision, recall, and F1-score
    %
    % This helper function calculates and displays the precision, recall,
    % and F1-score for each class in the dataset.

    classes = unique(actualLabels);
    numClasses = numel(classes);

    fprintf('\nClassification Report:\n');
    fprintf('Class\tPrecision\tRecall\t\tF1-score\n');
    fprintf('---------------------------------------------\n');

    for i = 1:numClasses
        class = classes(i);
        tp = sum((predictedLabels == class) & (actualLabels == class));
        fp = sum((predictedLabels == class) & (actualLabels ~= class));
        fn = sum((predictedLabels ~= class) & (actualLabels == class));

        precision = tp / (tp + fp);
        recall = tp / (tp + fn);
        f1Score = 2 * (precision * recall) / (precision + recall);

        fprintf('%d\t%.2f\t\t%.2f\t\t%.2f\n', class, precision, recall, f1Score);
    end
end

function [prec, rec, thresholds] = precisionRecallCurve(labels, scores)
    % precisionRecallCurve - Generate precision-recall curve data
    %
    % This helper function computes the precision-recall curve for binary
    % classification tasks.
    %
    % Inputs:
    %   labels - Actual class labels
    %   scores - Predicted scores or labels
    %
    % Outputs:
    %   prec - Precision values
    %   rec  - Recall values
    %   thresholds - Decision thresholds corresponding to precision-recall values

    [prec, rec, thresholds] = perfcurve(labels, scores, 1, 'xCrit', 'reca', 'yCrit', 'prec');
end
